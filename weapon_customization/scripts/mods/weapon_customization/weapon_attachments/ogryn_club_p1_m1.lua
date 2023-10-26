local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common_functions = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")

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

local functions = {
    head_attachments = function()
        return {
            {id = "head_default", name = "Default"},
            {id = "head_01",      name = "Head 1"},
            {id = "head_02",      name = "Head 2"},
            {id = "head_03",      name = "Head 3"},
            {id = "head_04",      name = "Head 4"},
            {id = "head_05",      name = "Head 5"},
            {id = "head_06",      name = "Krieg"},
        }
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "barrel"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            head_default = {model = "",                                         type = "head", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            head_01 =      {model = _item_melee.."/heads/shovel_ogryn_head_01", type = "head", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 2), no_support = tv(n, 2), hide_mesh = tv(h, 2), special_resolve = special_resolve},
            head_02 =      {model = _item_melee.."/heads/shovel_ogryn_head_02", type = "head", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 3), no_support = tv(n, 3), hide_mesh = tv(h, 3), special_resolve = special_resolve},
            head_03 =      {model = _item_melee.."/heads/shovel_ogryn_head_03", type = "head", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 4), no_support = tv(n, 4), hide_mesh = tv(h, 4), special_resolve = special_resolve},
            head_04 =      {model = _item_melee.."/heads/shovel_ogryn_head_04", type = "head", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 5), no_support = tv(n, 5), hide_mesh = tv(h, 5), special_resolve = special_resolve},
            head_05 =      {model = _item_melee.."/heads/shovel_ogryn_head_05", type = "head", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 6), no_support = tv(n, 6), hide_mesh = tv(h, 6), special_resolve = special_resolve},
            head_06 =      {model = _item_melee.."/full/krieg_shovel_ogryn_full_01", type = "head", parent = tv(parent, 7), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 7), no_support = tv(n, 7), hide_mesh = tv(h, 7), special_resolve = special_resolve}
        }
    end,
    grip_attachments = function()
        return {
            {id = "grip_default", name = "Default"},
            {id = "grip_01",      name = "Grip 1"},
            {id = "grip_02",      name = "Grip 2"},
            {id = "grip_03",      name = "Grip 3"},
            {id = "grip_04",      name = "Grip 4"},
            {id = "grip_05",      name = "Grip 5"},
        }
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "barrel"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            grip_default = {model = "",                                         type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            grip_01 =      {model = _item_melee.."/grips/shovel_ogryn_grip_01", type = "grip", parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2), hide_mesh = tv(h, 2), special_resolve = special_resolve},
            grip_02 =      {model = _item_melee.."/grips/shovel_ogryn_grip_02", type = "grip", parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3), hide_mesh = tv(h, 3), special_resolve = special_resolve},
            grip_03 =      {model = _item_melee.."/grips/shovel_ogryn_grip_03", type = "grip", parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4), no_support = tv(n, 4), hide_mesh = tv(h, 4), special_resolve = special_resolve},
            grip_04 =      {model = _item_melee.."/grips/shovel_ogryn_grip_04", type = "grip", parent = tv(parent, 5), angle = a, move = m, remove = r, automatic_equip = tv(ae, 5), no_support = tv(n, 5), hide_mesh = tv(h, 5), special_resolve = special_resolve},
            grip_05 =      {model = _item_melee.."/grips/shovel_ogryn_grip_05", type = "grip", parent = tv(parent, 6), angle = a, move = m, remove = r, automatic_equip = tv(ae, 6), no_support = tv(n, 6), hide_mesh = tv(h, 6), special_resolve = special_resolve},
        }
    end,
    pommel_attachments = function()
        return {
            {id = "pommel_default", name = "Default"},
            {id = "pommel_01",      name = "Pommel 1"},
            {id = "pommel_02",      name = "Pommel 2"},
            {id = "pommel_03",      name = "Pommel 3"},
            {id = "pommel_04",      name = "Pommel 4"},
            {id = "pommel_05",      name = "Pommel 5"},
        }
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "barrel"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            pommel_default = {model = "",                                             type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 1), no_support = tv(n, 1), hide_mesh = tv(h, 1), special_resolve = special_resolve},
            pommel_01 =      {model = _item_melee.."/pommels/shovel_ogryn_pommel_01", type = "pommel", parent = tv(parent, 2), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 2), no_support = tv(n, 2), hide_mesh = tv(h, 2), special_resolve = special_resolve},
            pommel_02 =      {model = _item_melee.."/pommels/shovel_ogryn_pommel_02", type = "pommel", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 3), no_support = tv(n, 3), hide_mesh = tv(h, 3), special_resolve = special_resolve},
            pommel_03 =      {model = _item_melee.."/pommels/shovel_ogryn_pommel_03", type = "pommel", parent = tv(parent, 4), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 4), no_support = tv(n, 4), hide_mesh = tv(h, 4), special_resolve = special_resolve},
            pommel_04 =      {model = _item_melee.."/pommels/shovel_ogryn_pommel_04", type = "pommel", parent = tv(parent, 5), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 5), no_support = tv(n, 5), hide_mesh = tv(h, 5), special_resolve = special_resolve},
            pommel_05 =      {model = _item_melee.."/pommels/shovel_ogryn_pommel_05", type = "pommel", parent = tv(parent, 6), angle = a, move = m, remove = r, mesh_move = "both", automatic_equip = tv(ae, 6), no_support = tv(n, 6), hide_mesh = tv(h, 6), special_resolve = special_resolve},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 10.9.2023
            grip = functions.grip_attachments(),
            pommel = functions.pommel_attachments(),
            head = functions.head_attachments(),
            emblem_right = _common_functions.emblem_right_attachments(),
            emblem_left = _common_functions.emblem_left_attachments(),
            trinket_hook = _common_functions.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 10.9.2023
            _common_functions.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common_functions.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common_functions.trinket_hook_models("head", 0, vector3_box(.05, -4, 0), vector3_box(0, 0, -.2)),
            functions.head_models(nil, 0, vector3_box(.1, -4, -.1), vector3_box(0, 0, .4), "head", {
                {"trinket_hook_empty"},
            }, {}, {}, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") or string_find(attachment, "head_06") then
                    if mod:get_gear_setting(gear_id, "grip", item) ~= "grip_default" then changes["grip"] = "grip_default" end
                    if mod:get_gear_setting(gear_id, "pommel", item) ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                else
                    if mod:get_gear_setting(gear_id, "grip", item) == "grip_default" then changes["grip"] = "grip_01" end
                    if mod:get_gear_setting(gear_id, "pommel", item) == "pommel_default" then changes["pommel"] = "pommel_01" end
                end
                return changes
            end),
            functions.grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, 0, 0), "grip", {}, {}, {}, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") then
                    if mod:get_gear_setting(gear_id, "head", item) ~= "head_default" then changes["head"] = "head_default" end
                    if mod:get_gear_setting(gear_id, "pommel", item) ~= "pommel_default" then changes["pommel"] = "pommel_default" end
                else
                    if mod:get_gear_setting(gear_id, "head", item) == "head_default" then changes["head"] = "head_01" end
                    if mod:get_gear_setting(gear_id, "pommel", item) == "pommel_default" then changes["pommel"] = "pommel_01" end
                end
                return changes
            end),
            functions.pommel_models(nil, 0, vector3_box(-.15, -5, .3), vector3_box(0, 0, -.3), "pommel", {}, {}, {}, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") then
                    if mod:get_gear_setting(gear_id, "head", item) ~= "head_default" then changes["head"] = "head_default" end
                    if mod:get_gear_setting(gear_id, "grip", item) ~= "grip_default" then changes["grip"] = "grip_default" end
                else
                    if mod:get_gear_setting(gear_id, "head", item) == "head_default" then changes["head"] = "head_01" end
                    if mod:get_gear_setting(gear_id, "grip", item) == "grip_default" then changes["grip"] = "grip_01" end
                end
                return changes
            end)
        ),
        anchors = { -- Done 10.9.2023 Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"head_01", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .475), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_01", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .86), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .485), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_01", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .475), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .825), rotation = vector3_box(90, -5, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .47), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_02", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_02", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .86), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .51), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_02", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .85), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0375, -.2, .825), rotation = vector3_box(90, -25, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .5), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_03", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .85), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .6), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_03", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .86), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .615), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_03", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .85), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .6), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_03"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.0475, -.2, .825), rotation = vector3_box(90, -10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.135, 0, .585), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_04", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .95), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_04", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .96), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_04", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .95), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.15, 0, .695), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.02, -.17, .925), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.15, 0, .685), rotation = vector3_box(90, 0, 3), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_05", "grip_01"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.04, 0, .78), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .52), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_05", "grip_02"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.04, 0, .78), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .51), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_05", "grip_04"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.04, 0, .79), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .535), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_05"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(.04, 0, .77), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.115, 0, .525), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},

                {dependencies = {"head_06"}, -- Emblems
                    emblem_left = {parent = "grip", position = vector3_box(-.01, -.2, .82), rotation = vector3_box(90, -17.5, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.09, 0, .8075), rotation = vector3_box(90, 0, 3), scale = vector3_box(2.5, 2.5, 2.5)}},

                {emblem_left = {parent = "grip", position = vector3_box(.005, -.2, .82), rotation = vector3_box(90, -10, 183), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "grip", position = vector3_box(.0975, 0, .8075), rotation = vector3_box(90, 0, 3), scale = vector3_box(2.5, 2.5, 2.5)}},

                {dependencies = {"head_01", "grip_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_01", "grip_04"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .12), mesh_position = vector3_box(0, 0, -.24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_01", "grip_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_01", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_01", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_01"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_03", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_03", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_03"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_04", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_04", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_04"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.07), mesh_position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .035), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_05", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.05), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_05", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.05), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_02", "grip_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.05), mesh_position = vector3_box(0, 0, .1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_02", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_02", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .185), mesh_position = vector3_box(0, 0, -.370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_04", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_04", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_04"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_05", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_05", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_03", "grip_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .14), mesh_position = vector3_box(0, 0, -.28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_01", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_01", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_01"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, -.05), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, .05), mesh_position = vector3_box(0, 0, -.1), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, -.025), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_03", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_03", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_04", "grip_03"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .12), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.12), mesh_position = vector3_box(0, 0, .24), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .06), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_01", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_01", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_01"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .185), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.185), mesh_position = vector3_box(0, 0, .370), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .0925), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_03", "pommel_02"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_03", "pommel_05"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
                {dependencies = {"head_05", "grip_03"}, -- Grip
                    head = {offset = true, position = vector3_box(0, 0, .14), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    grip = {offset = true, position = vector3_box(0, 0, -.14), mesh_position = vector3_box(0, 0, .28), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
                    pommel = {offset = true, position = vector3_box(0, 0, .07), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}
                },
            },
        },
    }
)