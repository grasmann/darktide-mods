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
            {id = "grip_default",    name = mod:localize("mod_attachment_default")},
            {id = "hatchet_grip_01", name = "Tactical Axe 1"},
            {id = "hatchet_grip_02", name = "Tactical Axe 2"},
            {id = "hatchet_grip_03", name = "Tactical Axe 3"},
            {id = "hatchet_grip_04", name = "Tactical Axe 4"},
            {id = "hatchet_grip_05", name = "Tactical Axe 5"},
            {id = "hatchet_grip_06", name = "Tactical Axe 6"},
        }
    end,
    grip_models = function()
        return {
            grip_default =    {model = "",                                    type = "grip"},
            hatchet_grip_01 = {model = _item_melee.."/grips/hatchet_grip_01", type = "grip"},
            hatchet_grip_02 = {model = _item_melee.."/grips/hatchet_grip_02", type = "grip"},
            hatchet_grip_03 = {model = _item_melee.."/grips/hatchet_grip_03", type = "grip"},
            hatchet_grip_04 = {model = _item_melee.."/grips/hatchet_grip_04", type = "grip"},
            hatchet_grip_05 = {model = _item_melee.."/grips/hatchet_grip_05", type = "grip"},
            hatchet_grip_06 = {model = _item_melee.."/grips/hatchet_grip_06", type = "grip"},
        }
    end,
    head_attachments = function()
        return {
            {id = "head_default",    name = mod:localize("mod_attachment_default")},
            {id = "hatchet_head_01", name = "Tactical Axe 1"},
            {id = "hatchet_head_02", name = "Tactical Axe 2"},
            {id = "hatchet_head_03", name = "Tactical Axe 3"},
            {id = "hatchet_head_04", name = "Tactical Axe 4"},
            {id = "hatchet_head_05", name = "Tactical Axe 5"},
        }
    end,
    head_models = function()
        return {
            head_default =    {model = "",                                    type = "head"},
            hatchet_head_01 = {model = _item_melee.."/heads/hatchet_head_01", type = "head"},
            hatchet_head_02 = {model = _item_melee.."/heads/hatchet_head_02", type = "head"},
            hatchet_head_03 = {model = _item_melee.."/heads/hatchet_head_03", type = "head"},
            hatchet_head_04 = {model = _item_melee.."/heads/hatchet_head_04", type = "head"},
            hatchet_head_05 = {model = _item_melee.."/heads/hatchet_head_05", type = "head"},
        }
    end,
    pommel_attachments = function()
        return {
            {id = "pommel_default",    name = mod:localize("mod_attachment_default")},
            {id = "hatchet_pommel_01", name = "Tactical Axe 1"},
            {id = "hatchet_pommel_02", name = "Tactical Axe 2"},
            {id = "hatchet_pommel_03", name = "Tactical Axe 3"},
            {id = "hatchet_pommel_04", name = "Tactical Axe 4"},
        }
    end,
    pommel_models = function()
        return {
            pommel_default =    {model = "",                                        type = "pommel"},
            hatchet_pommel_01 = {model = _item_melee.."/pommels/hatchet_pommel_01", type = "pommel"},
            hatchet_pommel_02 = {model = _item_melee.."/pommels/hatchet_pommel_02", type = "pommel"},
            hatchet_pommel_03 = {model = _item_melee.."/pommels/hatchet_pommel_03", type = "pommel"},
            hatchet_pommel_04 = {model = _item_melee.."/pommels/hatchet_pommel_04", type = "pommel"},
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
            _common.emblem_right_models("head", 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.emblem_left_models("head", -3, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common_melee.axe_grip_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, 0)),
            _common_melee.axe_head_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common_melee.axe_pommel_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.2))
        ),
        anchors = {

        },
    }
)