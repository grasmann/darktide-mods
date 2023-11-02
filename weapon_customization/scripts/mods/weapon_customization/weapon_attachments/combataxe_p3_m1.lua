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
    head_attachments = function()
        return {
            {id = "shovel_head_default", name = mod:localize("mod_attachment_default")},
            {id = "shovel_head_01",      name = "Head 1"},
            {id = "shovel_head_02",      name = "Head 2"},
            {id = "shovel_head_03",      name = "Head 3"},
            {id = "shovel_head_04",      name = "Head 4"},
            {id = "shovel_head_05",      name = "Head 5"},
        }
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "head"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            shovel_head_default =   {model = "",                                        type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1), special_resolve = special_resolve},
            shovel_head_01 =        {model = _item_melee.."/heads/shovel_head_01",      type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2), special_resolve = special_resolve},
            shovel_head_02 =        {model = _item_melee.."/heads/shovel_head_02",      type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3), special_resolve = special_resolve},
            shovel_head_03 =        {model = _item_melee.."/heads/shovel_head_03",      type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4), no_support = tv(n, 4), special_resolve = special_resolve},
            shovel_head_04 =        {model = _item_melee.."/heads/shovel_head_04",      type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, automatic_equip = tv(ae, 5), no_support = tv(n, 5), special_resolve = special_resolve},
            shovel_head_05 =        {model = _item_melee.."/heads/shovel_head_05",      type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, automatic_equip = tv(ae, 6), no_support = tv(n, 6), special_resolve = special_resolve},
        }
    end,
    grip_attachments = function()
        return {
            {id = "shovel_grip_default", name = mod:localize("mod_attachment_default")},
            {id = "shovel_grip_01",      name = "Grip 1"},
            {id = "shovel_grip_02",      name = "Grip 2"},
            {id = "shovel_grip_03",      name = "Grip 3"},
            {id = "shovel_grip_04",      name = "Grip 4"},
            {id = "shovel_grip_05",      name = "Grip 5"},
        }
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "grip"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            shovel_grip_default =   {model = "",                                   type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1), special_resolve = special_resolve},
            shovel_grip_01 =        {model = _item_melee.."/grips/shovel_grip_01", type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2), special_resolve = special_resolve},
            shovel_grip_02 =        {model = _item_melee.."/grips/shovel_grip_02", type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3), special_resolve = special_resolve},
            shovel_grip_03 =        {model = _item_melee.."/grips/shovel_grip_03", type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4), no_support = tv(n, 4), special_resolve = special_resolve},
            shovel_grip_04 =        {model = _item_melee.."/grips/shovel_grip_04", type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, automatic_equip = tv(ae, 5), no_support = tv(n, 5), special_resolve = special_resolve},
            shovel_grip_05 =        {model = _item_melee.."/grips/shovel_grip_05", type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, automatic_equip = tv(ae, 6), no_support = tv(n, 6), special_resolve = special_resolve},
        }
    end,
    pommel_attachments = function()
        return {
            {id = "shovel_pommel_default", name = mod:localize("mod_attachment_default")},
            {id = "shovel_pommel_01",      name = "Pommel 1"},
            {id = "shovel_pommel_02",      name = "Pommel 2"},
            {id = "shovel_pommel_03",      name = "Pommel 3"},
            {id = "shovel_pommel_04",      name = "Pommel 4"},
            {id = "shovel_pommel_05",      name = "Pommel 5"},
            {id = "shovel_pommel_06",      name = "Krieg"},
        }
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, special_resolve)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        local t = type or "pommel"
        local n = no_support or {}
        local ae = automatic_equip or {}
        local h = hide_mesh or {}
        return {
            shovel_pommel_default = {model = "",                                        type = t, parent = tv(parent, 1), angle = a, move = m, remove = r, automatic_equip = tv(ae, 1), no_support = tv(n, 1), special_resolve = special_resolve},
            shovel_pommel_01 =      {model = _item_melee.."/pommels/shovel_pommel_01",  type = t, parent = tv(parent, 2), angle = a, move = m, remove = r, automatic_equip = tv(ae, 2), no_support = tv(n, 2), special_resolve = special_resolve},
            shovel_pommel_02 =      {model = _item_melee.."/pommels/shovel_pommel_02",  type = t, parent = tv(parent, 3), angle = a, move = m, remove = r, automatic_equip = tv(ae, 3), no_support = tv(n, 3), special_resolve = special_resolve},
            shovel_pommel_03 =      {model = _item_melee.."/pommels/shovel_pommel_03",  type = t, parent = tv(parent, 4), angle = a, move = m, remove = r, automatic_equip = tv(ae, 4), no_support = tv(n, 4), special_resolve = special_resolve},
            shovel_pommel_04 =      {model = _item_melee.."/pommels/shovel_pommel_04",  type = t, parent = tv(parent, 5), angle = a, move = m, remove = r, automatic_equip = tv(ae, 5), no_support = tv(n, 5), special_resolve = special_resolve},
            shovel_pommel_05 =      {model = _item_melee.."/pommels/shovel_pommel_05",  type = t, parent = tv(parent, 6), angle = a, move = m, remove = r, automatic_equip = tv(ae, 6), no_support = tv(n, 6), special_resolve = special_resolve},
            shovel_pommel_06 =      {model = _item_melee.."/full/krieg_shovel_full_01", type = t, parent = tv(parent, 7), angle = a, move = m, remove = r, automatic_equip = tv(ae, 7), no_support = tv(n, 7), special_resolve = special_resolve},
        }
    end
}

return table.combine(
    functions,
    {
        attachments = {
            trinket_hook = _common.trinket_hook_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            head = functions.head_attachments(),
            pommel = functions.pommel_attachments(),
            grip = functions.grip_attachments(),
        },
        models = table.combine(
            _common.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(.05, -4, 0), vector3_box(0, 0, -.2)),
            functions.head_models(nil, 0, vector3_box(.1, -4, -.1), vector3_box(0, 0, .4), "head", {
                -- {"trinket_hook_empty"},
            }, {}, {}, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") then
                    if mod:get_gear_setting(gear_id, "grip", item) ~= "shovel_grip_default" then changes["grip"] = "shovel_grip_default" end
                    if mod:get_gear_setting(gear_id, "pommel", item) ~= "shovel_pommel_default" then changes["pommel"] = "shovel_pommel_default" end
                else
                    if mod:get_gear_setting(gear_id, "grip", item) == "shovel_grip_default" then changes["grip"] = "shovel_grip_01" end
                    local pommel = mod:get_gear_setting(gear_id, "pommel", item)
                    if pommel == "shovel_pommel_default" or pommel == "shovel_pommel_06" then changes["pommel"] = "shovel_pommel_01" end
                end
                return changes
            end),
            functions.grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, 0, 0), "grip", {}, {}, {}, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") then
                    if mod:get_gear_setting(gear_id, "head", item) ~= "shovel_head_default" then changes["head"] = "shovel_head_default" end
                    if mod:get_gear_setting(gear_id, "pommel", item) ~= "shovel_pommel_default" then changes["pommel"] = "shovel_pommel_default" end
                else
                    if mod:get_gear_setting(gear_id, "head", item) == "shovel_head_default" then changes["head"] = "shovel_head_01" end
                    local pommel = mod:get_gear_setting(gear_id, "pommel", item)
                    if pommel == "shovel_pommel_default" or pommel == "shovel_pommel_06" then changes["pommel"] = "shovel_pommel_01" end
                end
                return changes
            end),
            functions.pommel_models(nil, 0, vector3_box(-.15, -5, .3), vector3_box(0, 0, -.3), "pommel", {}, {}, {}, function(gear_id, item, attachment)
                local changes = {}
                if string_find(attachment, "default") or string_find(attachment, "shovel_pommel_06") then
                    if mod:get_gear_setting(gear_id, "head", item) ~= "shovel_head_default" then changes["head"] = "shovel_head_default" end
                    if mod:get_gear_setting(gear_id, "grip", item) ~= "shovel_grip_default" then changes["grip"] = "shovel_grip_default" end
                else
                    if mod:get_gear_setting(gear_id, "head", item) == "shovel_head_default" then changes["head"] = "shovel_head_01" end
                    if mod:get_gear_setting(gear_id, "grip", item) == "shovel_grip_default" then changes["grip"] = "shovel_grip_01" end
                end
                return changes
            end)
        ),
        anchors = {

        },
    }
)