local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common_functions = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _lasgun_common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/lasgun_common")
local _shotgun_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/shotgun_p1_m1")

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
    body_attachments = function()
        return {
            {id = "body_default",   name = "Default"},
            {id = "body_01",        name = "Body 1"},
        }
    end,
    body_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            body_default = {model = "",                                          type = "body", parent = tv(parent, 1), angle = a, move = m, remove = r},
            body_01 =      {model = _item_melee.."/full/stubgun_pistol_full_01", type = "body", parent = tv(parent, 2), angle = a, move = m, remove = r},
        }
    end,
    barrel_attachments = function()
        return {
            {id = "barrel_default", name = "Default"},
            {id = "barrel_01",      name = "Barrel 1"},
            {id = "barrel_02",      name = "Barrel 2"},
            {id = "barrel_03",      name = "Barrel 3"},
        }
    end,
    barrel_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            barrel_default = {model = "",                                                type = "barrel", parent = tv(parent, 1), angle = a, move = m, remove = r},
            barrel_01 =      {model = _item_ranged.."/barrels/stubgun_pistol_barrel_01", type = "barrel", parent = tv(parent, 2), angle = a, move = m, remove = r},
            barrel_02 =      {model = _item_ranged.."/barrels/stubgun_pistol_barrel_02", type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = r},
            barrel_03 =      {model = _item_ranged.."/barrels/stubgun_pistol_barrel_03", type = "barrel", parent = tv(parent, 4), angle = a, move = m, remove = r},
        }
    end,
    rail_attachments = function()
        return {
            {id = "rail_default",   name = "Default"},
            {id = "rail_01",        name = "Rail 1"},
        }
    end,
    rail_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            rail_default = {model = "",                                             type = "rail", parent = tv(parent, 1), angle = a, move = m, remove = r},
            rail_01 =      {model = _item_ranged.."/rails/stubgun_pistol_rail_off", type = "rail", parent = tv(parent, 2), angle = a, move = m, remove = r},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 13.9.2023
            flashlight = _common_functions.flashlights_attachments(),
            body = functions.body_attachments(),
            barrel = functions.barrel_attachments(),
            -- rail = functions.rail_attachments(),
            sight_2 = table.icombine(
                _common_functions.sight_default(),
                _common_functions.reflex_sights_attachments()
            ),
            rail = _lasgun_common.rail_attachments(),
            stock_3 = _shotgun_p1_m1.stock_attachments(),
            emblem_right = _common_functions.emblem_right_attachments(),
            emblem_left = _common_functions.emblem_left_attachments(),
        },
        models = table.combine( -- Done 13.9.2023
            {customization_default_position = vector3_box(-.2, 0, 0)},
            _common_functions.flashlight_models("body", -2.5, vector3_box(0, -3, 0), vector3_box(.2, 0, 0)),
            _common_functions.emblem_right_models("body", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common_functions.emblem_left_models("body", 0, vector3_box(0, -4, 0), vector3_box(-.2, 0, 0)),
            _shotgun_p1_m1.stock_models("body", 0, vector3_box(-.4, -4, 0), vector3_box(0, -.2, -.11), "stock_3"),
            functions.body_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0)),
            -- functions.rail_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _lasgun_common.rail_models("body", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common_functions.reflex_sights_models("body", -.5, vector3_box(0, -4, -.2), vector3_box(0, -.2, 0), "sight_2", {}, {
                {rail = "rail_default"},
                {rail = "rail_01"},
                {rail = "rail_01"},
                {rail = "rail_01"},
            }, {
                {},
                {{"barrel", 8}},
                {{"barrel", 8}},
                {{"barrel", 8}},
            })
        ),
        anchors = { -- Done 13.9.2023
            scope_offset = {position = vector3_box(0, .1, .03)},
            flashlight_01 = {position = vector3_box(.01, .07, .01), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)},
            flashlight_02 = {position = vector3_box(.01, .07, .01), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)},
            flashlight_03 = {position = vector3_box(.01, .07, .01), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)},
            flashlight_04 = {position = vector3_box(.01, .07, .01), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)},
            fixes = {
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"laser_pointer"}, -- Laser Pointer
                    flashlight = {position = vector3_box(.01, .07, .01), rotation = vector3_box(0, 0, 0), scale = vector3_box(.5, .5, .5)}},
                {dependencies = {"emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "body", position = vector3_box(-.011, .045, .0095), rotation = vector3_box(0, 0, 180), scale = vector3_box(.65, -.65, .65)}},
                {emblem_left = {parent = "body", position = vector3_box(-.011, .045, .0095), rotation = vector3_box(0, 0, 180), scale = vector3_box(.65, .65, .65)}, -- Emblems
                    emblem_right = {parent = "body", position = vector3_box(.011, .045, .0095), rotation = vector3_box(0, 0, 0), scale = vector3_box(.65, .65, .65)}},
                {dependencies = {"reflex_sight_01"}, -- Sight
                    sight_2 = {parent = "barrel", parent_node = 9, position = vector3_box(0, .022, .015), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .75, 1)}},
                {dependencies = {"reflex_sight_02"}, -- Sight
                    sight_2 = {parent = "barrel", parent_node = 9, position = vector3_box(0, .022, .015), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .75, 1)}},
                {dependencies = {"reflex_sight_03"}, -- Sight
                    sight_2 = {parent = "barrel", parent_node = 9, position = vector3_box(0, .022, .015), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .75, 1)}},
                {rail = {parent = "barrel", parent_node = 9, position = vector3_box(0, .02, .015), rotation = vector3_box(0, 0, 0), scale = vector3_box(.8, .75, 1)}}, -- Rail
                {stock_3 = {parent = "body", position = vector3_box(0, -.09, -.11), rotation = vector3_box(-10, 0, 0), scale = vector3_box(1, 1, 1)}}, -- Stocks
            }
        },
    }
)