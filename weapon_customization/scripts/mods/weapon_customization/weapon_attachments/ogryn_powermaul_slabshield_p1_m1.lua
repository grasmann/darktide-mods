local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common_functions = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _ogryn_powermaul_p1_m1 = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/ogryn_powermaul_p1_m1")

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
    shield_attachments = function()
        return {
            {id = "left_default",       name = "Default"},
            {id = "left_01",            name = "Slab Shield"},
            -- {id = "bulwark_shield_01",  name = "Bulwark Shield",    sounds = {_receiver_sound}},
        }
    end,
    shield_models = function(parent, angle, move, remove)
        local a = angle or 0
        local m = move or vector3_box(0, 0, 0)
        local r = remove or vector3_box(0, 0, 0)
        return {
            left_default =      {model = "",                                                     type = "left", parent = tv(parent, 1), angle = a, move = m, remove = r},
            left_01 =           {model = _item_melee.."/ogryn_slabshield_p1_m1",                 type = "left", parent = tv(parent, 2), angle = a, move = m, remove = r},
            -- bulwark_shield_01 = {model = _item_minion.."/shields/chaos_ogryn_bulwark_shield_01", type = "left", parent = tv(parent, 3), angle = a, move = m, remove = r, mesh_move = false},
        }
    end,
}

return table.combine(
    functions,
    {
        attachments = { -- Done 11.9.2023
            shaft = _ogryn_powermaul_p1_m1.shaft_attachments(),
            head = _ogryn_powermaul_p1_m1.head_attachments(),
            pommel = _ogryn_powermaul_p1_m1.pommel_attachments(),
            emblem_right = _common_functions.emblem_right_attachments(),
            emblem_left = _common_functions.emblem_left_attachments(),
            trinket_hook = _common_functions.trinket_hook_attachments(),
            left = functions.shield_attachments(),
        },
        models = table.combine( -- Done 11.9.2023
            -- {customization_default_position = vector3_box(.2, 0, 0)},
            _ogryn_powermaul_p1_m1.shaft_models(nil, -2.5, vector3_box(0, -5, -.15), vector3_box(0, 0, 0)),
            _common_functions.emblem_right_models("head", 0, vector3_box(0, -5, -.4), vector3_box(.2, 0, 0)),
            _common_functions.emblem_left_models("head", -3, vector3_box(0, -5, -.4), vector3_box(-.2, 0, 0)),
            _common_functions.trinket_hook_models(nil, -2.5, vector3_box(-.3, -4, .3), vector3_box(0, 0, -.2)),
            _ogryn_powermaul_p1_m1.head_models(nil, -2.5, vector3_box(0, -5, -.4), vector3_box(0, 0, .2)),
            _ogryn_powermaul_p1_m1.pommel_models(nil, -2.5, vector3_box(0, -6, .1), vector3_box(0, 0, -.2)),
            functions.shield_models(nil, 0, vector3_box(-.15, -2, .1), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Done 11.9.2023 Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"pommel_05"}, -- Trinket hook
                    trinket_hook = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.01, .01, .01)}},
                {dependencies = {"head_01"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.08, -.08, .54), rotation = vector3_box(90, 45, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "head", position = vector3_box(.08, .08, .54), rotation = vector3_box(90, 45, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"head_02"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.185, -.005, .315), rotation = vector3_box(90, 0, 185), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "head", position = vector3_box(.185, -.005, .315), rotation = vector3_box(90, 0, -5), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"head_03"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.21, 0, .280), rotation = vector3_box(90, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "head", position = vector3_box(.21, 0, .280), rotation = vector3_box(90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"head_04"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.045, .105, .12), rotation = vector3_box(90, 0, 180), scale = vector3_box(1.75, 1.75, 1.75)},
                    emblem_right = {parent = "head", position = vector3_box(.045, -.105, .12), rotation = vector3_box(90, 0, 0), scale = vector3_box(1.75, 1.75, 1.75)}},
                {dependencies = {"head_05"}, -- Emblems
                    emblem_left = {parent = "head", position = vector3_box(-.16, -.05, .3), rotation = vector3_box(90, 10, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "head", position = vector3_box(.16, -.05, .3), rotation = vector3_box(90, -10, 0), scale = vector3_box(2, 2, 2)}},
            }
        },
    }
)