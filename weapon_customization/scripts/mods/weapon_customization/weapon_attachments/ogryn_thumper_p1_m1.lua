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
    grip_attachments = function()
        return {
            {id = "grip_default",   name = mod:localize("mod_attachment_default")},
            {id = "grip_01",        name = "Grip 1"},
            {id = "grip_02",        name = "Grip 2"},
            {id = "grip_03",        name = "Grip 3"},
            {id = "grip_04",        name = "Grip 4"},
            {id = "grip_05",        name = "Grip 5"},
        }
    end,
    grip_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            grip_default = {model = "",                                             type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            grip_01 =      {model = _item_ranged.."/grips/shotgun_grenade_grip_01", type = "grip", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2)},
            grip_02 =      {model = _item_ranged.."/grips/shotgun_grenade_grip_02", type = "grip", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3)},
            grip_03 =      {model = _item_ranged.."/grips/shotgun_grenade_grip_03", type = "grip", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4)},
            grip_04 =      {model = _item_ranged.."/grips/shotgun_grenade_grip_04", type = "grip", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5)},
            grip_05 =      {model = _item_ranged.."/grips/shotgun_grenade_grip_05", type = "grip", parent = tv(parent, 6), angle = a, move = m, remove = tv(r, 6)},
        }
    end,
    sight_attachments = function()
        return {
            {id = "sight_default",  name = mod:localize("mod_attachment_default")},
            {id = "sight_01",       name = "Sight 1"},
            {id = "sight_02",       name = "No Sight"},
            {id = "sight_03",       name = "Sight 3"},
            {id = "sight_04",       name = "Sight 4"},
        }
    end,
    sight_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            sight_default = {model = "",                                               type = "sight", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            sight_01 =      {model = _item_ranged.."/sights/shotgun_grenade_sight_01", type = "sight", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2)},
            sight_02 =      {model = _item_ranged.."/sights/shotgun_grenade_sight_02", type = "sight", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3)},
            sight_03 =      {model = _item_ranged.."/sights/shotgun_grenade_sight_03", type = "sight", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4)},
            sight_04 =      {model = _item_ranged.."/sights/shotgun_grenade_sight_04", type = "sight", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5)},
        }
    end,
    body_attachments = function()
        return {
            {id = "body_default", name = mod:localize("mod_attachment_default")},
            {id = "body_01",      name = "Body 1"},
            {id = "body_02",      name = "Body 2"},
            {id = "body_03",      name = "Body 3"},
            {id = "body_04",      name = "Body 4"},
            {id = "body_05",      name = "Body 5"},
        }
    end,
    body_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            body_default = {model = "",                                           type = "body", parent = tv(parent, 1), angle = a, move = m, remove = tv(r, 1)},
            body_01 =      {model = _item_melee.."/full/shotgun_grenade_full_01", type = "body", parent = tv(parent, 2), angle = a, move = m, remove = tv(r, 2)},
            body_02 =      {model = _item_melee.."/full/shotgun_grenade_full_02", type = "body", parent = tv(parent, 3), angle = a, move = m, remove = tv(r, 3)},
            body_03 =      {model = _item_melee.."/full/shotgun_grenade_full_03", type = "body", parent = tv(parent, 4), angle = a, move = m, remove = tv(r, 4)},
            body_04 =      {model = _item_melee.."/full/shotgun_grenade_full_04", type = "body", parent = tv(parent, 5), angle = a, move = m, remove = tv(r, 5)},
            body_05 =      {model = _item_melee.."/full/shotgun_grenade_full_05", type = "body", parent = tv(parent, 6), angle = a, move = m, remove = tv(r, 6)},
        }
    end
}

return table.combine(
    functions,
    {
        attachments = { -- Done 8.9.2023
            flashlight = _common_ranged.flashlights_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            bayonet = _common_ranged.ogryn_bayonet_attachments(),
            sight = functions.sight_attachments(),
            grip = functions.grip_attachments(),
            body = functions.body_attachments()
        },
        models = table.combine( -- Done 8.9.2023
            _common_ranged.flashlight_models("receiver", -2.25, vector3_box(0, -3, 0), vector3_box(.4, 0, 0)),
            _common.emblem_right_models("receiver", -3, vector3_box(-.3, -6, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(-.1, -6, 0), vector3_box(-.2, 0, 0)),
            _common_ranged.ogryn_bayonet_models("body", -.5, vector3_box(.4, -2, 0), vector3_box(0, .4, 0)),
            functions.grip_models(nil, 0, vector3_box(-.3, -3, 0), vector3_box(0, -.2, 0)),
            functions.sight_models(nil, -.5, vector3_box(.2, -3, 0), vector3_box(0, 0, .2)),
            functions.body_models(nil, 0, vector3_box(0, -1, 0), vector3_box(0, 0, -.00001))
        ),
        anchors = { -- Done 8.9.2023
            flashlight_01 =    {position = vector3_box(.12, .33, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)},
            flashlight_02 =    {position = vector3_box(.12, .33, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)},
            flashlight_03 =    {position = vector3_box(.12, .33, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)},
            flashlight_04 =    {position = vector3_box(.12, .33, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)},
            bayonet_blade_01 = {parent = "body", parent_node = 12, position = vector3_box(0, .4, 0), rotation = vector3_box(-90, 0, 0), scale = vector3_box(1.5, 1.5, 1.5)},
            bayonet_01 =       {parent = "body", parent_node = 12, position = vector3_box(0, .4, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            bayonet_02 =       {parent = "body", parent_node = 12, position = vector3_box(0, .4, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            bayonet_03 =       {parent = "body", parent_node = 12, position = vector3_box(0, .4, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)},
            fixes = {
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.12, .33, .11), rotation = vector3_box(0, 360, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"emblem_left_02"}, -- Emblem
                    emblem_left = {offset = true, position = vector3_box(-.12, .22, .11), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, -2, 2)}},
                {emblem_left = {offset = true, position = vector3_box(-.12, .22, .11), rotation = vector3_box(0, 0, 180), scale = vector3_box(2, 2, 2)}, -- Emblems
                    emblem_right = {offset = true, position = vector3_box(.123, .765, .11), rotation = vector3_box(0, 0, 0), scale = vector3_box(2, 2, 2)}},
            }
        },
    }
)