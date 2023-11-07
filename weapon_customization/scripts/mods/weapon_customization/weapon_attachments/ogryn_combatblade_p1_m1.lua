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

-- ##### ┌─┐┬ ┬┌┐┌┌─┐┌┬┐┬┌─┐┌┐┌┌─┐ ####################################################################################
-- ##### ├┤ │ │││││   │ ││ ││││└─┐ ####################################################################################
-- ##### └  └─┘┘└┘└─┘ ┴ ┴└─┘┘└┘└─┘ ####################################################################################

local functions = {
    blade_attachments = function(default)
        local attachments = {
            {id = "blade_01", name = "Blade 1"},
            {id = "blade_02", name = "Blade 2"},
            {id = "blade_03", name = "Blade 3"},
            {id = "blade_04", name = "Blade 4"},
            {id = "blade_05", name = "Blade 5"},
            {id = "blade_06", name = "Blade 6"},
            {id = "blade_07", name = "Blade 7"},
            {id = "blade_08", name = "Blade 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "blade_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    blade_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "blade_default", model = ""},
            {name = "blade_01",      model = _item_melee.."/blades/combat_blade_blade_01"},
            {name = "blade_02",      model = _item_melee.."/blades/combat_blade_blade_02"},
            {name = "blade_03",      model = _item_melee.."/blades/combat_blade_blade_03"},
            {name = "blade_04",      model = _item_melee.."/blades/combat_blade_blade_04"},
            {name = "blade_05",      model = _item_melee.."/blades/combat_blade_blade_05"},
            {name = "blade_06",      model = _item_melee.."/blades/combat_blade_blade_06"},
            {name = "blade_07",      model = _item_melee.."/blades/combat_blade_blade_07"},
            {name = "blade_08",      model = _item_melee.."/blades/combat_blade_blade_08"},
        }, parent, angle, move, remove, type or "blade", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    grip_attachments = function(default)
        local attachments = {
            {id = "grip_01", name = "Grip 1"},
            {id = "grip_02", name = "Grip 2"},
            {id = "grip_03", name = "Grip 3"},
            {id = "grip_04", name = "Grip 4"},
            {id = "grip_05", name = "Grip 5"},
            {id = "grip_06", name = "Grip 6"},
            {id = "grip_07", name = "Grip 7"},
            {id = "grip_08", name = "Grip 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "grip_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    grip_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "grip_default", model = ""},
            {name = "grip_01",      model = _item_melee.."/grips/combat_blade_grip_01"},
            {name = "grip_02",      model = _item_melee.."/grips/combat_blade_grip_02"},
            {name = "grip_03",      model = _item_melee.."/grips/combat_blade_grip_03"},
            {name = "grip_04",      model = _item_melee.."/grips/combat_blade_grip_04"},
            {name = "grip_05",      model = _item_melee.."/grips/combat_blade_grip_05"},
            {name = "grip_06",      model = _item_melee.."/grips/combat_blade_grip_06"},
            {name = "grip_07",      model = _item_melee.."/grips/combat_blade_grip_07"},
            {name = "grip_08",      model = _item_melee.."/grips/combat_blade_grip_08"},
        }, parent, angle, move, remove, type or "grip", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    handle_attachments = function(default)
        local attachments = {
            {id = "handle_01", name = "Handle 1"},
            {id = "handle_02", name = "Handle 2"},
            {id = "handle_03", name = "Handle 3"},
            {id = "handle_04", name = "Handle 4"},
            {id = "handle_05", name = "Handle 5"},
            {id = "handle_06", name = "Handle 6"},
            {id = "handle_07", name = "Handle 7"},
            {id = "handle_08", name = "Handle 8"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "handle_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    handle_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "handle_default", model = ""},
            {name = "handle_01",      model = _item_ranged.."/handles/combat_blade_handle_01"},
            {name = "handle_02",      model = _item_ranged.."/handles/combat_blade_handle_02"},
            {name = "handle_03",      model = _item_ranged.."/handles/combat_blade_handle_03"},
            {name = "handle_04",      model = _item_ranged.."/handles/combat_blade_handle_04"},
            {name = "handle_05",      model = _item_ranged.."/handles/combat_blade_handle_05"},
            {name = "handle_06",      model = _item_ranged.."/handles/combat_blade_handle_06"},
            {name = "handle_07",      model = _item_ranged.."/handles/combat_blade_handle_07"},
            {name = "handle_08",      model = _item_ranged.."/handles/combat_blade_handle_08"},
        }, parent, angle, move, remove, type or "handle", no_support, automatic_equip, hide_mesh, mesh_move)
    end
}

-- ##### ┌┬┐┌─┐┌─┐┬┌┐┌┬┌┬┐┬┌─┐┌┐┌┌─┐ ##################################################################################
-- #####  ││├┤ ├┤ │││││ │ ││ ││││└─┐ ##################################################################################
-- ##### ─┴┘└─┘└  ┴┘└┘┴ ┴ ┴└─┘┘└┘└─┘ ##################################################################################

return table.combine(
    functions,
    {
        attachments = {
            -- Native
            blade = functions.blade_attachments(),
            grip = functions.grip_attachments(),
            handle = functions.handle_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            -- Native
            functions.blade_models(nil, 0, vector3_box(.1, -3, -.1), vector3_box(0, 0, .2)),
            functions.grip_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, .2, 0), nil, {
                {},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
                {"trinket_hook_empty"},
            }, {
                {},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "!trinket_hook_empty|trinket_hook_empty"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
                {trinket_hook = "trinket_hook_empty|trinket_hook_01"},
            }),
            functions.handle_models(nil, 0, vector3_box(-.15, -5, .2), vector3_box(0, 0, -.2)),
            -- Common
            _common.emblem_right_models("grip", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("grip", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(-.3, -4, .3), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Additional custom positions for paper thing emblems?
            fixes = {
                {dependencies = {"grip_05", "!handle_05"}, -- Trinket hook
                    trinket_hook = {offset = true, position = vector3_box(0, 0, .055), rotation = vector3_box(0, 0, 0), scale = vector3_box(1, 1, 1)}},
                {dependencies = {"blade_01"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .02, .375), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .02, .375), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_02"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, -.01, .275), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, -.01, .275), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_03"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .015, .175), rotation = vector3_box(90, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .015, .175), rotation = vector3_box(90, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"blade_04"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .04, .525), rotation = vector3_box(90, 0, 180), scale = vector3_box(3, 3, 3)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .04, .525), rotation = vector3_box(90, 0, 0), scale = vector3_box(3, 3, 3)}},
                {dependencies = {"blade_05"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, .06, .125), rotation = vector3_box(83, 0, 180), scale = vector3_box(2, 2, 2)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, .06, .125), rotation = vector3_box(83, 0, 0), scale = vector3_box(2, 2, 2)}},
                {dependencies = {"blade_06"}, -- Emblems
                    emblem_left = {parent = "blade", position = vector3_box(-.02, 0, .275), rotation = vector3_box(90, 0, 180), scale = vector3_box(4, 4, 4)},
                    emblem_right = {parent = "blade", position = vector3_box(.02, 0, .275), rotation = vector3_box(90, 0, 0), scale = vector3_box(4, 4, 4)}},
            },
        },
    }
)