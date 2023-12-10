local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local _common = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common")
local _common_ranged = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_ranged")
local _common_lasgun = mod:io_dofile("weapon_customization/scripts/mods/weapon_customization/weapon_attachments/common_lasgun")

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
    receiver_attachments = function(default)
        -- return {
        --     {id = "receiver_default",   name = mod:localize("mod_attachment_default")},
        --     {id = "receiver_01",        name = "Receiver 1"},
        -- }
        local attachments = {
            {id = "receiver_01", name = "Receiver 1"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "receiver_default",   name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    receiver_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        -- local a = angle or 0
        -- local m = move or vector3_box(0, 0, 0)
        -- local r = remove or vector3_box(0, 0, 0)
        -- return {
        --     receiver_default = {model = "",                                                  type = "receiver", parent = tv(parent, 1), angle = a, move = m, remove = r},
        --     receiver_01 =      {model = _item_ranged.."/recievers/plasma_rifle_receiver_01", type = "receiver", parent = tv(parent, 2), angle = a, move = m, remove = r},
        -- }
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "receiver_default", model = ""},
            {name = "receiver_01",      model = _item_ranged.."/recievers/plasma_rifle_receiver_01"},
        }, parent, angle, move, remove, type or "receiver", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    magazine_attachments = function(default)
        -- return {
        --     {id = "magazine_default",   name = mod:localize("mod_attachment_default")},
        --     {id = "magazine_01",        name = "Magazine 1"},
        --     {id = "magazine_02",        name = "Magazine 2"},
        --     {id = "magazine_03",        name = "Magazine 3"},
        --     -- {id = "magazine_04",        name = "Magazine 4"},
        -- }
        local attachments = {
            {id = "magazine_01", name = "Magazine 1"},
            {id = "magazine_02", name = "Magazine 2"},
            {id = "magazine_03", name = "Magazine 3"},
            -- {id = "magazine_04",        name = "Magazine 4"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "magazine_default",   name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    magazine_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        -- local a = angle or 0
        -- local m = move or vector3_box(0, 0, 0)
        -- local r = remove or vector3_box(0, 0, 0)
        -- return {
        --     magazine_default = {model = "",                                                  type = "magazine", parent = tv(parent, 1), angle = a, move = m, remove = r},
        --     magazine_01 =      {model = _item_ranged.."/magazines/plasma_rifle_magazine_01", type = "magazine", parent = tv(parent, 2), angle = a, move = m, remove = r},
        --     magazine_02 =      {model = _item_ranged.."/magazines/plasma_rifle_magazine_02", type = "magazine", parent = tv(parent, 3), angle = a, move = m, remove = r},
        --     magazine_03 =      {model = _item_ranged.."/magazines/melta_gun_magazine_01",    type = "magazine", parent = tv(parent, 4), angle = a, move = m, remove = r},
        --     -- magazine_04 =      {model = _item_ranged.."/magazines/plasma_rifle_magazine_03", type = "magazine", parent = tv(parent, 4), angle = a, move = m, remove = r},
        -- }
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "magazine_default", model = ""},
            {name = "magazine_01",      model = _item_ranged.."/magazines/plasma_rifle_magazine_01"},
            {name = "magazine_02",      model = _item_ranged.."/magazines/plasma_rifle_magazine_02"},
            {name = "magazine_03",      model = _item_ranged.."/magazines/melta_gun_magazine_01"},
            -- {name = "magazine_04",      model = _item_ranged.."/magazines/plasma_rifle_magazine_03"},
        }, parent, angle, move, remove, type or "magazine", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    barrel_attachments = function(default)
        -- return {
        --     {id = "barrel_default", name = mod:localize("mod_attachment_default")},
        --     {id = "barrel_01",      name = "Barrel 1"},
        --     {id = "barrel_02",      name = "Barrel 2"},
        --     {id = "barrel_03",      name = "Barrel 3"},
        --     -- {id = "barrel_04",      name = "Barrel 4"},
        -- }
        local attachments = {
            {id = "barrel_01", name = "Barrel 1"},
            {id = "barrel_02", name = "Barrel 2"},
            {id = "barrel_03", name = "Barrel 3"},
            -- {id = "barrel_04",      name = "Barrel 4"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "barrel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    barrel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        -- local a = angle or 0
        -- local m = move or vector3_box(0, 0, 0)
        -- local r = remove or vector3_box(0, 0, 0)
        -- return {
        --     barrel_default = {model = "",                                              type = "barrel", parent = tv(parent, 1), angle = a, move = m, remove = r},
        --     barrel_01 =      {model = _item_ranged.."/barrels/plasma_rifle_barrel_01", type = "barrel", parent = tv(parent, 2), angle = a, move = m, remove = r},
        --     barrel_02 =      {model = _item_ranged.."/barrels/plasma_rifle_barrel_02", type = "barrel", parent = tv(parent, 3), angle = a, move = m, remove = r},
        --     barrel_03 =      {model = _item_ranged.."/barrels/plasma_rifle_barrel_03", type = "barrel", parent = tv(parent, 4), angle = a, move = m, remove = r},
        --     -- barrel_04 =      {model = _item_ranged.."/barrels/plasma_rifle_barrel_04", type = "barrel", parent = tv(parent, 5), angle = a, move = m, remove = r},
        -- }
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "barrel_default", model = ""},
            {name = "barrel_01",      model = _item_ranged.."/barrels/plasma_rifle_barrel_01"},
            {name = "barrel_02",      model = _item_ranged.."/barrels/plasma_rifle_barrel_02"},
            {name = "barrel_03",      model = _item_ranged.."/barrels/plasma_rifle_barrel_03"},
            -- {name = "barrel_04",      model = _item_ranged.."/barrels/plasma_rifle_barrel_04"},
        }, parent, angle, move, remove, type or "barrel", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    stock_attachments = function(default)
        -- return {
        --     {id = "plasma_rifle_stock_default", name = mod:localize("mod_attachment_default")},
        --     {id = "plasma_rifle_stock_01",      name = "Ventilation 1"},
        --     {id = "plasma_rifle_stock_02",      name = "Ventilation 2"},
        --     {id = "plasma_rifle_stock_03",      name = "Ventilation 3"},
        --     {id = "plasma_rifle_stock_04",      name = "Ventilation 4"},
        -- }
        local attachments = {
            {id = "plasma_rifle_stock_01", name = "Ventilation 1"},
            {id = "plasma_rifle_stock_02", name = "Ventilation 2"},
            {id = "plasma_rifle_stock_03", name = "Ventilation 3"},
            {id = "plasma_rifle_stock_04", name = "Ventilation 4"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "plasma_rifle_stock_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    stock_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        -- local a = angle or 0
        -- local m = move or vector3_box(0, 0, 0)
        -- local r = remove or vector3_box(0, 0, 0)
        -- return {
        --     plasma_rifle_stock_default = {model = "",                                            type = "stock", parent = tv(parent, 1), angle = a, move = m, remove = r},
        --     plasma_rifle_stock_01 =      {model = _item_ranged.."/stocks/plasma_rifle_stock_01", type = "stock", parent = tv(parent, 2), angle = a, move = m, remove = r},
        --     plasma_rifle_stock_02 =      {model = _item_ranged.."/stocks/plasma_rifle_stock_02", type = "stock", parent = tv(parent, 3), angle = a, move = m, remove = r},
        --     plasma_rifle_stock_03 =      {model = _item_ranged.."/stocks/plasma_rifle_stock_03", type = "stock", parent = tv(parent, 4), angle = a, move = m, remove = r},
        --     plasma_rifle_stock_04 =      {model = _item_ranged.."/stocks/plasma_rifle_stock_04", type = "stock", parent = tv(parent, 4), angle = a, move = m, remove = r},
        -- }
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "plasma_rifle_stock_default", model = ""},
            {name = "plasma_rifle_stock_01",      model = _item_ranged.."/stocks/plasma_rifle_stock_01"},
            {name = "plasma_rifle_stock_02",      model = _item_ranged.."/stocks/plasma_rifle_stock_02"},
            {name = "plasma_rifle_stock_03",      model = _item_ranged.."/stocks/plasma_rifle_stock_03"},
            {name = "plasma_rifle_stock_04",      model = _item_ranged.."/stocks/plasma_rifle_stock_04"},
        }, parent, angle, move, remove, type or "stock", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end,
    grip_attachments = function(default)
        -- return {
        --     {id = "grip_default",   name = mod:localize("mod_attachment_default")},
        --     {id = "grip_01",        name = "Grip 1"},
        --     {id = "grip_02",        name = "Grip 2"},
        --     {id = "grip_03",        name = "Grip 3"},
        -- }
        local attachments = {
            {id = "grip_01", name = "Grip 1"},
            {id = "grip_02", name = "Grip 2"},
            {id = "grip_03", name = "Grip 3"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "grip_default",   name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
        -- local a = angle or 0
        -- local m = move or vector3_box(0, 0, 0)
        -- local r = remove or vector3_box(0, 0, 0)
        -- return {
        --     grip_default = {model = "",                                          type = "grip", parent = tv(parent, 1), angle = a, move = m, remove = r},
        --     grip_01 =      {model = _item_ranged.."/grips/plasma_rifle_grip_01", type = "grip", parent = tv(parent, 2), angle = a, move = m, remove = r},
        --     grip_02 =      {model = _item_ranged.."/grips/plasma_rifle_grip_02", type = "grip", parent = tv(parent, 3), angle = a, move = m, remove = r},
        --     grip_03 =      {model = _item_ranged.."/grips/plasma_rifle_grip_03", type = "grip", parent = tv(parent, 4), angle = a, move = m, remove = r},
        -- }
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "grip_default", model = ""},
            {name = "grip_01",      model = _item_ranged.."/grips/plasma_rifle_grip_01"},
            {name = "grip_02",      model = _item_ranged.."/grips/plasma_rifle_grip_02"},
            {name = "grip_03",      model = _item_ranged.."/grips/plasma_rifle_grip_03"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move, special_resolve)
    end
}

return table.combine(
    functions,
    {
        attachments = { -- Done 14.9.2023
            sight = table.icombine(
                _common_ranged.reflex_sights_attachments()--,
                -- _common_ranged.scopes_attachments(false)
            ),
            receiver = functions.receiver_attachments(),
            magazine = functions.magazine_attachments(),
            barrel = functions.barrel_attachments(),
            -- grip = functions.grip_attachments(),
            grip = _common_ranged.grip_attachments(),
            stock = functions.stock_attachments(),
            -- rail = _common_lasgun.rail_attachments(),
            stock_2 = _common_ranged.stock_attachments(),
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine( -- Done 14.9.2023
            _common_ranged.reflex_sights_models("receiver", -.5, vector3_box(-.3, -4, -.2), vector3_box(0, -.2, 0), "sight", nil, {
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
            }),
            _common_ranged.sights_models("body", .35, vector3_box(0, -4, -.2), {
                vector3_box(-.2, 0, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(0, -.2, 0),
                vector3_box(-.2, 0, 0),
                vector3_box(0, -.3, 0),
                vector3_box(0, -.4, 0),
                vector3_box(0, -.15, 0),
                vector3_box(0, -.2, 0),
            }, "sight", {}, {
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_01", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "scope_sight_02", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "scope_sight_03", lens = "scope_lens_02", lens_2 = "scope_lens_2_02"},
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
            }, {
                {},
                {},
                {},
                {},
                {{"sight", 1}},
                {},
                {},
                {},
                {},
            }, {
                true,
                true,
                false,
                false,
                true,
                false,
                false,
                false,
                false,
            }),
            _common_ranged.scope_sights_models("sight", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0), "sight_2", {}, {
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
                {rail = "rail_default"},
                {rail = "rail_default"},
                {rail = "rail_default"},
                {rail = "rail_default", sight_2 = "sight_default", lens = "scope_lens_default", lens_2 = "scope_lens_default"},
            }),
            _common_ranged.scope_lens_models("sight", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.scope_lens_2_models("sight", .2, vector3_box(0, -4, -.2), vector3_box(0, 0, 0)),
            _common_ranged.stock_models("receiver", .5, vector3_box(-.4, -4, 0), vector3_box(0, -.2, 0), "stock_2"),
            _common_lasgun.rail_models("receiver", 0, vector3_box(0, 0, 0), vector3_box(0, 0, .2)),
            _common.emblem_right_models("receiver", -3, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("receiver", 0, vector3_box(0, -4, 0), vector3_box(-.2, 0, 0)),
            functions.receiver_models(nil, 0, vector3_box(0, 0, 0), vector3_box(0, 0, -.00001)),
            functions.magazine_models(nil, .1, vector3_box(-.2, -3, .1), vector3_box(0, 0, -.2)),
            functions.barrel_models(nil, -.5, vector3_box(.2, -2, 0), vector3_box(0, .2, 0), "barrel", {
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
            }),
            functions.stock_models(nil, .75, vector3_box(-.3, -4, -.1), vector3_box(0, -.015, .1)),
            _common.trinket_hook_models("barrel", -.2, vector3_box(.1, -4, .2), vector3_box(0, 0, -.2)),
            functions.grip_models(nil, .2, vector3_box(-.3, -4, .1), vector3_box(0, -.1, -.1))
        ),
        anchors = { -- Done 14.9.2023
            scope_offset = {position = vector3_box(.063, .15, -.00675)},
            fixes = {
                --#region Scope
                    -- Ranger's Vigil
                    {dependencies = {"scope_03"},
                        sight = {parent = "receiver", position = vector3_box(-.065, -.04, .165), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1),
                            animation_wait_attach = {"rail"}
                        },
                        lens = {parent = "sight", position = vector3_box(0, .033, .002), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, .4, .9), data = {lens = 1}},
                        lens_2 = {parent = "sight", position = vector3_box(0, .085, .002), rotation = vector3_box(180, 0, 0), scale = vector3_box(.9, .4, .9), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, 0, -.0425), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}},
                            animation_wait_attach = {"rail"}
                        },
                        scope_offset = {position = vector3_box(.05, .15, -.0145), rotation = vector3_box(-5, -7.5, 0)}},
                    -- Martyr's Gaze
                    {dependencies = {"scope_01"},
                        sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1.5, 1),
                            animation_wait_attach = {"rail"}
                        },
                        lens = {parent = "sight", position = vector3_box(0, .105, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, .275, 1), data = {lens = 1}},
                        lens_2 = {parent = "sight", position = vector3_box(0, .065, 0), rotation = vector3_box(180, 0, 0), scale = vector3_box(1, .3, 1), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, .07, -.045), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 5}},
                            animation_wait_attach = {"rail"}
                        },
                        scope_offset = {position = vector3_box(0, .015, .0135), rotation = vector3_box(.6, 0, 0)}},
                    -- Exterminatus Lens
                    {dependencies = {"scope_02"},
                        sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 3, 1),
                            animation_wait_attach = {"rail"}
                        },
                        lens = {parent = "sight", position = vector3_box(0, .075, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(.9, .15, .9), data = {lens = 1}},
                        lens_2 = {parent = "sight", position = vector3_box(0, .022, 0), rotation = vector3_box(180, 0, 0), scale = vector3_box(.9, .1, .9), data = {lens = 2}},
                        sight_2 = {parent = "sight", position = vector3_box(0, .07, -.048), rotation = vector3_box(0, 0, 0), scale = vector3_box(1.5, .4, 1.35), hide_mesh = {{"sight_2", 3, 4, 5}},
                            animation_wait_attach = {"rail"}
                        },
                        scope_offset = {position = vector3_box(0, .17, .01), rotation = vector3_box(.6, 0, 0)}},
                    -- {sight_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0),
                    --     animation_wait_attach = {"rail"}
                    -- }},
                    -- {lens = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                    -- {lens_2 = {offset = true, position = vector3_box(0, 0, 0), rotation = vector3_box(0, 0, 0), scale = vector3_box(0, 0, 0)}},
                --#endregion
                {dependencies = {"grip_27|grip_28|grip_29"}, -- Grip
                    grip = {offset = true, position = vector3_box(0, .01, -.02), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_01", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.0415, .3, -.025), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(1, -1, 1)}},
                {dependencies = {"barrel_01"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.0415, .3, -.025), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"barrel_02", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.043, .2965, -.033), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(.65, -.65, .65)}},
                {dependencies = {"barrel_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.043, .2965, -.033), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(.65, .65, .65)}},
                {dependencies = {"barrel_03", "emblem_left_02"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.04, .375, -.023), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(.65, -.65, .65)}},
                {dependencies = {"barrel_03"}, -- Emblem
                    emblem_left = {parent = "barrel", position = vector3_box(-.04, .375, -.023), rotation = vector3_box(0, -5, 177.5), scale = vector3_box(.65, .65, .65)}},
                {emblem_right = {parent = "receiver", position = vector3_box(.062, .115, -.005), rotation = vector3_box(0, 0, 0), scale = vector3_box(.65, .65, .65)}},
                {dependencies = {"magazine_03"}, -- Sight
                    magazine = {offset = true, position = vector3_box(0, -.06, 0), rotation = vector3_box(90, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_01"}, -- Sight
                    sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_02"}, -- Sight
                    sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"reflex_sight_03"}, -- Sight
                    sight = {parent = "receiver", position = vector3_box(-.046, .01, .150), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, 1, 1)}},
                {rail = {parent = "receiver", position = vector3_box(-.045, -.005, .15), rotation = vector3_box(0, -52, 0), scale = vector3_box(1, .3, 1)}}, -- Rail
                {stock_2 = {parent = "receiver", position = vector3_box(0, -0.095, 0.055), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}}, -- Stocks
            },
        },
    }
)