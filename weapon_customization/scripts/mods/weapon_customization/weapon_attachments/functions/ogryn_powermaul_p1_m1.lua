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
    shaft_attachments = function(default)
        local attachments = {
            {id = "shaft_01", name = "Shaft 1"},
            {id = "shaft_02", name = "Shaft 2"},
            {id = "shaft_03", name = "Shaft 3"},
            {id = "shaft_04", name = "Shaft 4"},
            {id = "shaft_05", name = "Shaft 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "shaft_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    shaft_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "shaft_default", model = ""},
            {name = "shaft_01",      model = _item_ranged.."/shafts/power_maul_shaft_01"},
            {name = "shaft_02",      model = _item_ranged.."/shafts/power_maul_shaft_02"},
            {name = "shaft_03",      model = _item_ranged.."/shafts/power_maul_shaft_03"},
            {name = "shaft_04",      model = _item_ranged.."/shafts/power_maul_shaft_04"},
            {name = "shaft_05",      model = _item_ranged.."/shafts/power_maul_shaft_05"},
        }, parent, angle, move, remove, type or "shaft", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    head_attachments = function(default)
        local attachments = {
            {id = "head_01", name = "Head 1"},
            {id = "head_02", name = "Head 2"},
            {id = "head_03", name = "Head 3"},
            {id = "head_04", name = "Head 4"},
            {id = "head_05", name = "Head 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "head_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    head_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "head_default", model = ""},
            {name = "head_01",      model = _item_melee.."/heads/power_maul_head_01"},
            {name = "head_02",      model = _item_melee.."/heads/power_maul_head_02"},
            {name = "head_03",      model = _item_melee.."/heads/power_maul_head_03"},
            {name = "head_04",      model = _item_melee.."/heads/power_maul_head_04"},
            {name = "head_05",      model = _item_melee.."/heads/power_maul_head_05"},
        }, parent, angle, move, remove, type or "head", no_support, automatic_equip, hide_mesh, mesh_move)
    end,
    pommel_attachments = function(default)
        local attachments = {
            {id = "pommel_01", name = "Pommel 1"},
            {id = "pommel_02", name = "Pommel 2"},
            {id = "pommel_03", name = "Pommel 3"},
            {id = "pommel_04", name = "Pommel 4"},
            {id = "pommel_05", name = "Pommel 5"},
        }
        if default == nil then default = true end
        if default then return table.icombine(
            {{id = "pommel_default", name = mod:localize("mod_attachment_default")}},
            attachments)
        else return attachments end
    end,
    pommel_models = function(parent, angle, move, remove, type, no_support, automatic_equip, hide_mesh, mesh_move)
        if mesh_move == nil then mesh_move = false end
        return table.model_table({
            {name = "pommel_default", model = ""},
            {name = "pommel_01",      model = _item_melee.."/pommels/power_maul_pommel_01"},
            {name = "pommel_02",      model = _item_melee.."/pommels/power_maul_pommel_02"},
            {name = "pommel_03",      model = _item_melee.."/pommels/power_maul_pommel_03"},
            {name = "pommel_04",      model = _item_melee.."/pommels/power_maul_pommel_04"},
            {name = "pommel_05",      model = _item_melee.."/pommels/power_maul_pommel_05"},
        }, parent, angle, move, remove, type or "pommel", no_support, automatic_equip, hide_mesh, mesh_move)
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
            shaft = functions.shaft_attachments(),
            head = functions.head_attachments(),
            pommel = functions.pommel_attachments(),
            -- Common
            emblem_right = _common.emblem_right_attachments(),
            emblem_left = _common.emblem_left_attachments(),
            trinket_hook = _common.trinket_hook_attachments(),
        },
        models = table.combine(
            {customization_default_position = vector3_box(0, 2, 0)},
            -- Native
            functions.shaft_models(nil, 0, vector3_box(-.1, -4, .2), vector3_box(0, 0, 0)),
            functions.head_models(nil, 0, vector3_box(.3, -3, -.3), vector3_box(0, 0, .2)),
            functions.pommel_models(nil, 0, vector3_box(-.25, -5, .4), vector3_box(0, 0, -.2)),
            -- Common
            _common.emblem_right_models("head", -2.5, vector3_box(0, -4, 0), vector3_box(.2, 0, 0)),
            _common.emblem_left_models("head", 0, vector3_box(.1, -4, -.1), vector3_box(-.2, 0, 0)),
            _common.trinket_hook_models(nil, 0, vector3_box(-.3, -4, .3), vector3_box(0, 0, -.2))
        ),
        anchors = { -- Additional custom positions for paper thing emblems?
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