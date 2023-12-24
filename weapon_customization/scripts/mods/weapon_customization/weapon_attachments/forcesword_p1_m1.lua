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
            {id = "force_sword_grip_default", name = mod:localize("mod_attachment_default")},
            {id = "force_sword_grip_01",      name = "Grip 1"},
            {id = "force_sword_grip_02",      name = "Grip 2"},
            {id = "force_sword_grip_03",      name = "Grip 3"},
            {id = "force_sword_grip_04",      name = "Grip 4"},
            {id = "force_sword_grip_05",      name = "Grip 5"},
            {id = "force_sword_grip_06",      name = "Grip 6"},
            {id = "force_sword_grip_07",      name = "Grip 7"},
            {id = "force_sword_grip_08",      name = "Grip 8"},
            {id = "force_sword_grip_09",      name = "Grip 9"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            force_sword_grip_default = {model = "",                                        type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_01 =      {model = _item_melee.."/grips/force_sword_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_02 =      {model = _item_melee.."/grips/force_sword_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_03 =      {model = _item_melee.."/grips/force_sword_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_04 =      {model = _item_melee.."/grips/force_sword_grip_04", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_05 =      {model = _item_melee.."/grips/force_sword_grip_05", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_06 =      {model = _item_melee.."/grips/2h_power_sword_grip_01", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_07 =      {model = _item_melee.."/grips/2h_power_sword_grip_02", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_08 =      {model = _item_melee.."/grips/2h_power_sword_grip_03", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_grip_09 =      {model = _item_melee.."/grips/force_sword_grip_06", type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    blade_attachments = function()
        return {
            {id = "force_sword_blade_default", name = mod:localize("mod_attachment_default")},
            {id = "force_sword_blade_01",      name = "Blade 1"},
            {id = "force_sword_blade_02",      name = "Blade 2"},
            {id = "force_sword_blade_03",      name = "Blade 3"},
            {id = "force_sword_blade_04",      name = "Blade 4"},
            {id = "force_sword_blade_05",      name = "Blade 5"},
            {id = "force_sword_blade_06",      name = "Blade 6"},
            {id = "force_sword_blade_07",      name = "Blade 7"},
            {id = "force_sword_blade_08",      name = "Blade 8"},
            {id = "force_sword_blade_09",      name = "Blade 9"},
        }
    end,
    blade_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            force_sword_blade_default = {model = "",                                          type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_01 =      {model = _item_melee.."/blades/force_sword_blade_01", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_02 =      {model = _item_melee.."/blades/force_sword_blade_02", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_03 =      {model = _item_melee.."/blades/force_sword_blade_03", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_04 =      {model = _item_melee.."/blades/force_sword_blade_04", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_05 =      {model = _item_melee.."/blades/force_sword_blade_05", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_06 =      {model = _item_melee.."/blades/2h_power_sword_blade_01", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_07 =      {model = _item_melee.."/blades/2h_power_sword_blade_02", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_08 =      {model = _item_melee.."/blades/2h_power_sword_blade_03", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_blade_09 =      {model = _item_melee.."/blades/force_sword_blade_06", type = "blade", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    pommel_attachments = function()
        return {
            {id = "force_sword_pommel_default", name = mod:localize("mod_attachment_default")},
            {id = "force_sword_pommel_01",      name = "Pommel 1"},
            {id = "force_sword_pommel_02",      name = "Pommel 2"},
            {id = "force_sword_pommel_03",      name = "Pommel 3"},
            {id = "force_sword_pommel_04",      name = "Pommel 4"},
            {id = "force_sword_pommel_05",      name = "Pommel 5"},
            {id = "force_sword_pommel_06",      name = "Pommel 6"},
            {id = "force_sword_pommel_07",      name = "Pommel 7"},
            {id = "force_sword_pommel_08",      name = "Pommel 8"},
        }
    end,
    pommel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            force_sword_pommel_default = {model = "",                                            type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_pommel_01 =      {model = _item_melee.."/pommels/force_sword_pommel_01", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_pommel_02 =      {model = _item_melee.."/pommels/force_sword_pommel_02", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_pommel_03 =      {model = _item_melee.."/pommels/force_sword_pommel_03", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_pommel_04 =      {model = _item_melee.."/pommels/force_sword_pommel_04", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_pommel_05 =      {model = _item_melee.."/pommels/force_sword_pommel_05", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_pommel_06 =      {model = _item_melee.."/pommels/2h_power_sword_pommel_01", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_pommel_07 =      {model = _item_melee.."/pommels/2h_power_sword_pommel_02", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_pommel_08 =      {model = _item_melee.."/pommels/2h_power_sword_pommel_03", type = "pommel", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
    hilt_attachments = function()
        return {
            {id = "force_sword_hilt_default", name = mod:localize("mod_attachment_default")},
            {id = "force_sword_hilt_01",      name = "Hilt 1"},
            {id = "force_sword_hilt_02",      name = "Hilt 2"},
            {id = "force_sword_hilt_03",      name = "Hilt 3"},
            {id = "force_sword_hilt_04",      name = "Hilt 4"},
            {id = "force_sword_hilt_05",      name = "Hilt 5"},
            {id = "force_sword_hilt_06",      name = "Hilt 6"},
            {id = "force_sword_hilt_07",      name = "Hilt 7"},
            {id = "force_sword_hilt_08",      name = "Hilt 8"},
            {id = "force_sword_hilt_09",      name = "Hilt 9"},
            {id = "force_sword_hilt_07",      name = "Hilt 7"},
        }
    end,
    hilt_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            force_sword_hilt_default = {model = "",                                        type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_01 =      {model = _item_melee.."/hilts/force_sword_hilt_01", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_02 =      {model = _item_melee.."/hilts/force_sword_hilt_02", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_03 =      {model = _item_melee.."/hilts/force_sword_hilt_03", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_04 =      {model = _item_melee.."/hilts/force_sword_hilt_04", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_05 =      {model = _item_melee.."/hilts/force_sword_hilt_05", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_06 =      {model = _item_melee.."/hilts/force_sword_hilt_06", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_07 =      {model = _item_melee.."/hilts/2h_power_sword_hilt_01", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_08 =      {model = _item_melee.."/hilts/2h_power_sword_hilt_02", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_09 =      {model = _item_melee.."/hilts/2h_power_sword_hilt_03", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
            force_sword_hilt_10 =      {model = _item_melee.."/hilts/force_sword_hilt_07", type = "hilt", parent = tv(parent, 1), angle = a, move = m, remove = r, mesh_move = false},
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
            pommel = functions.pommel_attachments(),
            hilt = functions.hilt_attachments(),
            blade = functions.blade_attachments(),
        },
        models = table.combine(
            -- {customization_default_position = vector3_box(0, 3, .35)},
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            functions.grip_models(nil, 0, vector3_box(-.3, -3, .2), vector3_box(0, 0, 0)),
            functions.hilt_models(nil, 0, vector3_box(0, -5.5, -.4), vector3_box(0, 0, .2)),
            functions.blade_models(nil, 0, vector3_box(.05, -4.5, -.5), vector3_box(0, 0, .4)),
            functions.pommel_models(nil, 0, vector3_box(-.5, -4, .5), vector3_box(0, 0, -.2))
        ),
        anchors = {

        },
    }
)